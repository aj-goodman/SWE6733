import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["profile", "container"]

    connect() {
        console.log("Connected to the Match Controller!")
    }

    reject(event) {
        this.profileTarget.style.background = "#dc354512"
        setTimeout(() => {
            this.profileTarget.style.opacity = 0;
        }, 1000)
        let profile
        fetch("/matches", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify( { id: event.target.dataset.id }
            ),
        })
            .then(response => response.json())
            .then(data => {
                profile = data.profile
                console.log(data);
            })
        setTimeout(() => {
            this.profileTarget.innerHTML = profile
        }, 2000)
        setTimeout(() => {
            this.profileTarget.style.opacity = 1
            this.profileTarget.style.background = "transparent"
        }, 2000)
    }
}