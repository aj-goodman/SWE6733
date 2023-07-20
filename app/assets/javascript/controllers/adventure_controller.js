import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["results", "badges", "search", "preview", "form"]
  connect() {
    console.log("Connected")
  }

  search(event) {
    if (event.target.value.length > 3) {
      fetch("/adventures/search", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify( { query: event.target.value } ),
      })
          .then(response => response.json())
          .then(data => this.searchResults(data, event.target.value));
    } else {
      this.resultsTarget.innerHTML = ""
      this.resultsTarget.classList.add("d-none")
    }
  }

  searchResults(data, input) {
    let results = '';
    if (data.length) {
      data.forEach(element => {
        results += `<div data-action="click->adventure#select" class="adventure-option p-1">${element.name}</div>`
      })
    } else {
      results += `<div data-action="click->adventure#select" class="adventure-option p-1 fst-italic">Add ${input}</div>`
    }
    this.resultsTarget.innerHTML = results
    this.resultsTarget.classList.remove("d-none")
  }

  select(event) {
    let badge = document.createElement("span")
    badge.classList = "adventure-badge bg-light border rounded p-2 me-2 form-control-sm"
    badge.dataset.action = "click->adventure#remove"
    let val = event.target.innerText.replace('Add ', '')
    badge.innerHTML = `${val} <i class="fa fa-sm ms-2 fa-close pe-none"></i>`
    let field = document.createElement("input")
    field.type = "hidden"
    field.name = "adventures[]"
    field.value = val
    badge.append(field)
    this.badgesTarget.append(badge)
    this.searchTarget.value = "";
    this.resultsTarget.innerHTML = ""
    this.resultsTarget.classList.add("d-none")
  }

  remove(event) {
    event.target.remove()
  }

  preview(event) {
    this.formTarget.classList.toggle("d-none")
    this.previewTarget.classList.toggle("d-none")
    if (event.target.innerText === "Preview Profile") {
      event.target.innerText = "Edit Profile"
    } else {
      event.target.innerText = "Preview Profile"
    }
  }
}
