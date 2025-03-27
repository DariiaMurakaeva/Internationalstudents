import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container", "icon"]

    toggle() {
        this.containerTarget.classList.toggle("None")
        this.iconTarget.classList.toggle("DropDownGreyDefault")
        this.iconTarget.classList.toggle("DropDownGreyActive")
    }
}