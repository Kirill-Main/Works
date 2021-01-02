window.sendQuesstion = function(id) {
    let quesstion = document.getElementById("quesstion").value;
    if (quesstion == "") {
        return;
    }

    let url = location.protocol + "//" + location.host + "/add_quesstion.json";
    let param_str = "?quesstion=" + quesstion + "&id=" + id;;
    let http_request = new XMLHttpRequest();

    http_request.open("GET", url + param_str);

    http_request.onreadystatechange = function () {
        let done = 4, ok = 200;
        if (http_request.readyState == done && http_request.status == ok) {
            data = JSON.parse(http_request.responseText);
            if (data.result) {
                let result = document.getElementById("result");
                result.innerText = "Ваш вопрос успешно добавлен"
                let btn = document.getElementById("result");
                btn.setAttribute("disabled", "disabled");
                let input = document.getElementById("quesstion");
                input.value = "";
            } else {
                let result = document.getElementById("result");
                result.innerText = "Произошла ошибка"
            }
        }
        };

    http_request.send(null);
}

window.sendAnswer = function(id) {
    let answer = document.getElementById("answer№" + id).value;
    if (answer == "") {
        return;
    }

    let url = location.protocol + "//" + location.host + "/add_answer.json";
    let param_str = "?answer=" + answer + "&id=" + id;
    let http_request = new XMLHttpRequest();

    http_request.open("GET", url + param_str);

    http_request.onreadystatechange = function () {
        let done = 4, ok = 200;
        if (http_request.readyState == done && http_request.status == ok) {
            data = JSON.parse(http_request.responseText);
            if (data.result) {
                let td = document.getElementById("td№" + id);
                td.innerText = answer;
            }
        }
        };

    http_request.send(null);
}