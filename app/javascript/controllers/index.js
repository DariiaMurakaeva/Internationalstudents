import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

import DiscussionsModalController from "./discussions_modal_controller"
import ReadMoreController from "./read_more_controller"

application.register("discussions-modal", DiscussionsModalController)
application.register("read-more", ReadMoreController)

eagerLoadControllersFrom("controllers", application)