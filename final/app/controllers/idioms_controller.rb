# frozen_string_literal: true

class IdiomsController < ApplicationController
  before_action :require_admin, only: %i[add new show_all]
  skip_before_action :require_login, only: %i[find save]

  def add; end

  def show_all
    @idioms = Idiom.all
  end

  def find
    idiom_from = params[:idiom_from]
    language_from = params[:language_from]
    language_to = params[:language_to]

    @result = find_idiom(idiom_from, language_from, language_to)
    set_result @result
  end

  def show_saved
    @idioms = Middle.all.select do |idiom|
                idiom.is_active && idiom.user_id == @current_user['id']
              end.map { |middle| Idiom.find_by(id: middle.idiom_id) }
  end

  def save
    str_from = params[:str_from]
    str_to = params[:str_to]

    unless @current_user
      set_result(false, 'Необходимо войти, чтобы сохранить идиомы!')
      return
    end

    if middle = Middle.find_by(idiom_id: session[:current_idiom]['id'], user_id: @current_user['id'],
                               is_active: false)
      middle.is_active = true
      middle.save
    elsif Middle.find_by(idiom_id: session[:current_idiom]['id'], user_id: @current_user['id'],
                         is_active: true).nil?
      middle = Middle.new(is_active: true, idiom_id: session[:current_idiom]['id'], user_id: @current_user['id'])
      middle.save
    elsif session[:current_idiom]['str_from'] == str_from && session[:current_idiom]['str_to'] == str_to
      set_result(false, 'Данная идиома уже была сохранена!')
      return
    else
      set_result(false, 'Произошла ошибка!')
      return
    end

    set_result true
  end

  def new
    str_from = params[:str_from]
    str_to = params[:str_to]

    if Idiom.find_by(str_from: str_from, str_to: str_to)
      @error = 'Данная идиома уже существует'
      render :add
      return
    end

    idiom = Idiom.new(str_from: str_from, language_from: 'ru', str_to: str_to, language_to: 'en')
    unless idiom.save
      @error = 'Проверьте правильность введенных данных'
      render :add
      return
    end

    redirect_to '/'
  end

  def remove_from_saved
    idiom_id = params[:idiom_id].to_i
    middle = Middle.find_by(idiom_id: idiom_id, user_id: @current_user['id'])
    middle.is_active = false
    middle.save
    redirect_to :show_saved
  end

  private

  def tanimoto(string1, string2)
    a = string1.length
    b = string2.length
    c = string1.split('').select { |sym| string2.include? sym }.length
    c.to_f / (a + b - c)
  end

  def find_idiom(idiom_from, language_from, language_to)
    equality_percentage = 0.9
    idioms_forward = Idiom.all.select do |idiom|
      tanimoto(idiom_from,
               idiom.str_from) > equality_percentage && idiom.language_from == language_from && idiom.language_to == language_to
    end
    idioms_backward = Idiom.all.select do |idiom|
      tanimoto(idiom_from,
               idiom.str_to) > equality_percentage && idiom.language_from == language_to && idiom.language_to == language_from
    end

    if idioms_forward.length.positive?
      session[:current_idiom] = idioms_forward.first
      return idioms_forward.first.str_to
    end

    if idioms_backward.length.zero?
      'К сожалению, идиома не найдена. Попробуйте повторить ввод или сообщить об этом на почту admin@yandex.ru'
    else
      session[:current_idiom] = idioms_backward.first
      idioms_backward.first.str_from
    end
  end

  def set_result(result, reason = nil)
    respond_to do |format|
      format.json do
        render json:
            { result: result, reason: reason }
      end
    end
  end
end
