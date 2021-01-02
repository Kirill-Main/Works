var languages = {
    "language_from": "ru", 
    "language_to": "en"
}

window.saveIdioms = function() {
    let idiom_from = document.getElementById("idiom_from").value;
    let idiom_to = document.getElementById("idiom_to").value;
    let result = document.getElementById("result");

    if (idiom_from == "" || idiom_to == "К сожалению, идиома не найдена. Попробуйте повторить ввод или сообщить об этом на почту admin@yandex.ru") {
      result.hidden = false;
      result.classList.remove("alert-success");
      result.classList.add("alert-danger");
      result.innerText = "Введите идиому!";
      document.getElementById("idiom_to").value = "";
      document.getElementById("idiom_from").value = "";
      return;
    }

    let url = location.protocol + "//" + location.host + "/save.json";
    let param_str = "?idiom_from=" + idiom_from + "&idiom_to=" + idiom_to;
    let http_request = new XMLHttpRequest();
    
    http_request.open("GET", url + param_str);

    http_request.onreadystatechange = function() {
      let done = 4, ok = 200;
      if (http_request.readyState == done && http_request.status == ok) {
        data = JSON.parse(http_request.responseText);
        let result = document.getElementById("result");
        result.hidden = false;
        if (data.result) {
          result.classList.remove("alert-danger");
          result.classList.add("alert-success");
          result.innerText = "Идиома успешно сохранена";
        } else {
          result.classList.remove("alert-success");
          result.classList.add("alert-danger");
          result.innerText = data.reason;
        }
      }
    };

    http_request.send(null);
    return false;
}

window.sendIdioms =  function() {
    let idiom_from = document.getElementById("idiom_from").value;
    if (idiom_from == "") {
      document.getElementById("idiom_to").value = "";
      return;
    }

    let url = location.protocol + "//" + location.host + "/find.json";
    let param_str = "?idiom_from=" + idiom_from + "&language_from=" + languages["language_from"] + "&language_to=" + languages["language_to"];
    let http_request = new XMLHttpRequest();
    
    http_request.open("GET", url + param_str);

    http_request.onreadystatechange = function() {
      let done = 4, ok = 200;
      if (http_request.readyState == done && http_request.status == ok) {
        data = JSON.parse(http_request.responseText);
        document.getElementById("idiom_to").value = data.result;
      }
    };

    http_request.send(null);
}

window.changeLanguage = function(button) {
    document.getElementById("idiom_from").value = "";
    document.getElementById("idiom_to").value = "";

    let input_buttons = document.getElementsByName("language_from")
    let output_buttons = document.getElementsByName("language_to")

    if (button.name == "language_from") {
      languages["language_to"] = languages["language_from"]
      languages["language_from"] = button.getAttribute('data')

      for(let btn of input_buttons) {
        if (btn.getAttribute('data') == languages[button.name]) {
          btn.classList.remove("btn-outline-primary");
          btn.classList.add("btn-primary");
        } else {
          btn.classList.remove("btn-primary");
          btn.classList.add("btn-outline-primary");
        }
      }

      for(let btn of output_buttons) {
        if (btn.getAttribute('data') == languages[button.name]) {
          btn.classList.remove("btn-primary");
          btn.classList.add("btn-outline-primary");
        } else {
          btn.classList.remove("btn-outline-primary");
          btn.classList.add("btn-primary");
        }
      }
    } else {
      languages["language_from"] = languages["language_to"]
      languages["language_to"] = button.getAttribute('data')

      for(let btn of output_buttons) {
        if (btn.getAttribute('data') == languages[button.name]) {
          btn.classList.remove("btn-outline-primary");
          btn.classList.add("btn-primary");
        } else {
          btn.classList.remove("btn-primary");
          btn.classList.add("btn-outline-primary");
        }
      }
      
      for(let btn of input_buttons) {
        if (btn.getAttribute('data') == languages[button.name]) {
          btn.classList.remove("btn-primary");
          btn.classList.add("btn-outline-primary");
        } else {
          btn.classList.remove("btn-outline-primary");
          btn.classList.add("btn-primary");
        }
      }
    }
}

window.clearResult = function() {
    document.getElementById("idiom_to").value = "";
    document.getElementById("idiom_from").value = "";
    document.getElementById("result").hidden = true;
}