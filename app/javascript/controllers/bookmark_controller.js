// app/javascript/controllers/bookmark_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["icon"]

    toggle(event) {
        event.preventDefault()
        const url = this.element.href
        const method = this.element.dataset.method

    fetch(url, {
        method: method,
        headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept": "application/json"
    }
    })
    .then(response => response.json())
    .then(data => {
        this.updateIcon(data.bookmarked)
    })
}

    updateIcon(isBookmarked) {
        if (isBookmarked) {
            this.iconTarget.classList.add("BookmarkBlackActive")
            this.iconTarget.classList.remove("BookmarkBlackDefault")
    } else {
        this.iconTarget.classList.add("BookmarkBlackDefault")
        this.iconTarget.classList.remove("BookmarkBlackActive")
    }
}
}