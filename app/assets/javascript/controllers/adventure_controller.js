import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["results"]
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
          .then(data => this.searchResults(data));
    }
  }

  searchResults(data) {
    let results = '';
    data.forEach(element => {
      results += `<div data-action="click->adventure#select" class="">${element.name}</div>`
    })
    this.resultsTarget.innerHTML = results
    this.resultsTarget.classList.remove("d-none")
  }

  select(event) {
    alert("hello!")
  }
}
