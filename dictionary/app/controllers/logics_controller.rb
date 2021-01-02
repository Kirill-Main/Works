# frozen_string_literal: true

class LogicsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def add
    str_from = params[:str_from]
    str_to = params[:str_to]

    if translation = Translation.find_by(user_id: @current_user['id'], str_from: str_from, is_hidden: true)
      translation.is_hidden = false
      result = translation.save
    elsif translation = Translation.find_by(user_id: @current_user['id'], str_from: str_from)
      result = false
    else
      translation = Translation.new str_from: str_from, str_to: str_to, user_id: @current_user['id']
      result = translation.save
    end

    respond_to do |format|
      format.json { render json: { result: result, number: translation.id, str_from: str_from, str_to: str_to } }
    end
  end

  def remove
    id = params[:id].to_i

    translation = Translation.find_by id: id
    translation.is_hidden = true
    translation.save

    respond_to do |format|
      format.json { render json: {} }
    end
  end

  def remove_all
    Translation.where(user_id: @current_user['id']).each do |translation|
      translation.is_hidden = true
      translation.save
    end

    respond_to do |format|
      format.json { render json: {} }
    end
  end

  def change
    str_from = params[:change_str_from]
    str_to = params[:change_str_to]
    id = params[:id_field].to_i

    translation = Translation.find_by id: id
    translation.str_from = str_from
    translation.str_to = str_to
    translation.save

    respond_to do |format|
      format.json { render json: { id: id, str_from: str_from, str_to: str_to } }
    end
  end
end
