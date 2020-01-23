import { Controller } from 'stimulus';

export default class extends Controller {
  initialize() {
    $('.challenges-form-tab-link').each(function() {
      $(this).click(function(event) {
        event.preventDefault();

        // I have to use JQuery here, because Bootstrap tabs use JQuery and
        // plain javascript won't trigger events on them
        $(event.target).tab('show');

        const challengeForm = document.getElementById('challenge-form');
        Rails.fire(challengeForm, 'submit');
      });
    })
  }
}
