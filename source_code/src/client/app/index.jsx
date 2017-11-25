// load stylesheet
require("../sass/default.scss");

var $ = require('jquery');

function createApplication() {

    var html = `
    <section class="hero is-primary">
        <div class="hero-body">
            <div class="container">
                <h1 class="title">
                    Congratulations
                </h1>
                <h2 class="subtitle">
                    You are currently running a NodeJS server.
                </h2>
            </div>
        </div>
    </section>
    `;

    $("#app").html(html);

}

createApplication();