// # app/javascript/packs/application.js
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
// import "channels"
import "../src/index"
import "../stylesheets/application.scss"

Rails.start()
ActiveStorage.start()
import "controllers"
