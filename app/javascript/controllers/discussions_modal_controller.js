import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "success"]

    connect() {
        console.log("Controller connected. Modal exists:", this.hasModalTarget)
    }

    showModal() {
        if (!this.hasModalTarget) {
            console.error("Modal target not found! Ensure modal is inside the controller scope.")
            return
        }
        this.modalTarget.style.display = "block"
        document.body.style.overflow = "hidden"
    }

    closeForm() {
        if (this.hasModalTarget) {
            this.modalTarget.style.display = "none"
            document.body.style.overflow = "auto"
        }
    }

    closeSuccess() {
        if (this.hasSuccessTarget) {
            this.successTarget.style.display = "none"
            document.body.style.overflow = "auto"
        }
    }

    goToDiscussions() {
        window.location.href = "/discussions";
    }
}
