import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
    static targets = ["chat", "input"]
    connect() {
        console.log("Connected to the Chat Controller!")
        let id = document.getElementById("chat").dataset.id
        setTimeout(() => this.checkMessages(id), 5000 )
    }

    checkMessages(id = id) {
        fetch(`/chats/${id}/retrieve`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            }
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                this.chatTarget.innerHTML = data.html
                console.log("Loaded new messages.")
            })
        setTimeout(() => this.checkMessages(id), 5000 )
    }

    sendMessage(event) {
        fetch(`/chats/${event.target.dataset.id}`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ message: { body: this.inputTarget.value } })
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                this.chatTarget.innerHTML = data.html
                console.log("Loaded new messages.")
                this.inputTarget.value = ""
            })
    }
}