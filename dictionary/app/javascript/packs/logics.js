document.addEventListener('DOMContentLoaded', function() {
    document.querySelector("#addForm").addEventListener(
    'ajax:success', function(event) {
        [data, status, xhr] = event.detail;
        showAddResult(data);
    })

    document.querySelector("#changeForm").addEventListener(
    'ajax:success', function(event) {
        [data, status, xhr] = event.detail;
        showChangeResult(data);
    })

    let tbody = document.getElementById("tbody")
    if (tbody.children.length == 0) {
        let table = document.getElementsByClassName("table")[0]
        table.hidden = true
        let removeTitle = document.getElementById("removeTitle")
        removeTitle.hidden = true
    }
})


window.showAddForm = function() {
    let addForm = document.getElementById("addForm")
    addForm.style.display = "block"
}


window.hideAddForm = function() {
    let addForm = document.getElementById("addForm")
    addForm.style.display = "none"
    document.getElementById("str_from").value = ""
    document.getElementById("str_to").value = ""
}


window.showAddResult = function(data) {
    if (!data.result) {
        let errorMessage = document.getElementById("errorMessage")
        errorMessage.hidden = false
        errorMessage.innerText = "Данное поле уже есть в словаре!"
        setTimeout(function() {
            let errorMessage = document.getElementById("errorMessage")
            errorMessage.hidden = true
            document.getElementById("str_from").value = ""
            document.getElementById("str_to").value = ""
        }, 2500)
        return
    }
    let tbody = document.getElementById("tbody")
    let tr = document.createElement("tr")
    tr.id = data.number
    let cells = [
        document.createElement("td"), document.createElement("td"),
        document.createElement("td"), document.createElement("td"),
        document.createElement("td")
    ]

    cells[0].innerText = document.getElementById("tbody").children.length + 1
    cells[1].innerText = data.str_from
    cells[1].id = "str_from№" + data.number
    cells[2].innerText = data.str_to
    cells[2].id = "str_to№" + data.number
    cells[3].innerHTML = '<a onclick="change(' + data.number + ')" class="text-info">Изменить</a>'
    cells[4].innerHTML = '<a onclick="remove(' + data.number + ')" class="text-danger">Удалить</a>'

    cells.forEach(function(cell) {
        tr.appendChild(cell)
    })
    tbody.appendChild(tr)
    let changeForm = document.getElementById("addForm")
    changeForm.style.display = "none"
    document.getElementById("str_from").value = ""
    document.getElementById("str_to").value = ""

    if (tbody.children.length == 1) {
        let table = document.getElementsByClassName("table")[0]
        table.hidden = false
        let removeTitle = document.getElementById("removeTitle")
        removeTitle.hidden = false
    }
}


window.remove = function(id) {
    let url = location.protocol + "//" + location.host + "/remove.json"
    let param_str = "id=" + id
    let http_request = new XMLHttpRequest()
    
    http_request.open("POST", url)
    http_request.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http_request.onreadystatechange = function() {
        let done = 4, ok = 200;
        if (http_request.readyState == done && http_request.status == ok) {
            let tbody = document.getElementById("tbody")
            let tr = document.getElementById(id)
            tbody.removeChild(tr)
            Array.from(tbody.children).forEach(function(value, index) {
                value.getElementsByTagName("td")[0].innerText = index + 1
            })

            if (tbody.children.length == 0) {
                let table = document.getElementsByClassName("table")[0]
                table.hidden = true
                let removeTitle = document.getElementById("removeTitle")
                removeTitle.hidden = true
            }
        }
    }

    http_request.send(param_str)
    return false
}


window.change = function(id) {
    let str_from = document.getElementById("str_from№" + id).innerText
    let str_to = document.getElementById("str_to№" + id).innerText
    let changeForm = document.getElementById("changeForm")
    changeForm.style.display = "block"
    document.getElementById("id_field").value = id
    document.getElementById("change_str_from").value = str_from
    document.getElementById("change_str_to").value = str_to
}


window.hideChangeForm = function() {
    let changeForm = document.getElementById("changeForm")
    changeForm.style.display = "none"
}


window.showChangeResult = function(data) {
    document.getElementById("str_from№" + data.id).innerText = data.str_from
    document.getElementById("str_to№" + data.id).innerText = data.str_to
    let changeForm = document.getElementById("changeForm")
    changeForm.style.display = "none"
}


window.removeAll = function() {
    let url = location.protocol + "//" + location.host + "/remove_all.json"
    let http_request = new XMLHttpRequest()

    http_request.open("POST", url)
    http_request.onreadystatechange = function() {
        let done = 4, ok = 200;
        if (http_request.readyState == done && http_request.status == ok) {
            let tbody = document.getElementById("tbody")
            Array.from(tbody.children).forEach(function(value) {
                tbody.removeChild(value)
            })

            let table = document.getElementsByClassName("table")[0]
            table.hidden = true
            let removeTitle = document.getElementById("removeTitle")
            removeTitle.hidden = true
        }
    }

    http_request.send(null)
    return false
}
