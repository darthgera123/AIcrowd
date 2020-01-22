module Challenges
  class EditFormsController < ApplicationController
    before_action :load_challenge
    before_action :load_organizer
    before_action :authorize_challenge

    SUCCESS_MESSAGE = 'Challenge updated.'.freeze

    def details
      if @challenge.update(details_params)
        redirect_to edit_challenge_path(@challenge, step: :details), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :details
      end
    end

    def overview
      if @challenge.update(overview_params)
        redirect_to edit_challenge_path(@challenge, step: :overview), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :overview
      end
    end

    def rounds
      if @challenge.update(rounds_params)
        redirect_to edit_challenge_path(@challenge, step: :rounds), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :rounds
      end
    end

    def private_challenge
      if @challenge.update(private_challenge_params)
        redirect_to edit_challenge_path(@challenge, step: :private_challenge), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :private_challenge
      end
    end

    def submissions
      if @challenge.update(submissions_params)
        redirect_to edit_challenge_path(@challenge, step: :submissions), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :submissions
      end
    end

    def winner
      if @challenge.update(winner_params)
        redirect_to edit_challenge_path(@challenge, step: :winner), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :winner
      end
    end

    def rules
      if @challenge.update(rules_params)
        redirect_to edit_challenge_path(@challenge, step: :rules), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :rules
      end
    end

    def admin
      if @challenge.update(admin_params)
        redirect_to edit_challenge_path(@challenge, step: :admin), notice: SUCCESS_MESSAGE
      else
        render 'challenges/edit', step: :admin
      end
    end

    private

    def load_challenge
      @challenge = Challenge.includes(:organizer).friendly.find(params[:challenge_id])
    end

    def load_organizer
      @organizer = @challenge.organizer
    end

    def authorize_challenge
      # authorize @challenge
    end

    def details_params
      params.require(:challenge).permit(
        :challenge,
        :tagline,
        :require_registration,
        :show_leaderboard,
        :media_on_leaderboard,
        :submissions_page,
        :grading_history,
        :grader_logs,
        :discussions_visible,
        :latest_submission,
        :teams_allowed,
        :hidden_challenge,
        :max_team_participants,
        :team_freeze_time,
        :status,
        :featured_sequence,
        :image_file,
        :challenge_client_name,
        :grader_identifier,
        :score_title,
        :score_secondary_title,
        :primary_sort_order,
        :secondary_sort_order,
        :other_scores_fieldname,
        :organizer_id,
        :discourse_category_id,
        :other_scores_fieldnames,
        image_attributes: [ # These may not be needed
          :id,
          :image,
          :_destroy
        ]
      )
    end

    def overview_params
      params.require(:challenge).permit(
        :description_markdown,
        :prize_cash,
        :prize_travel,
        :prize_academic,
        :prize_misc,
        challenge_partners_attributes: [
          :id,
          :image_file,
          :partner_url,
          :_destroy
        ]
      )
    end

    def rounds_params
      params.require(:challenge).permit(
        challenge_rounds_attributes: [
          :id,
          :challenge_round,
          :minimum_score,
          :minimum_score_secondary,
          :submission_limit,
          :submission_limit_period,
          :failed_submissions,
          :parallel_submissions,
          :ranking_highlight,
          :ranking_window,
          :score_precision,
          :score_secondary_precision,
          :start_dttm,
          :end_dttm,
          :active,
          :leaderboard_note_markdown,
          :_destroy
        ]
      )
    end

    def private_challenge_params
      params.require(:challenge).permit(
        :private_challenge,
        invitations_attributes: [
          :id,
          :email,
          :_destroy
        ]
      )
    end

    def submissions_params
      params.require(:challenge).permit(
        :clef_task_id,
        :online_submissions,
        :post_challenge_submissions,
        :submission_instructions_markdown,
        :license_markdown
      )
    end

    def winner_params
      params.require(:challenge).permit(
        :winners_tab_active,
        :winner_description_markdown
      )
    end

    def rules_params
      params.require(:challenge).permit(
        challenge_rules_attributes: [
          :id,
          :terms_markdown,
          :has_additional_checkbox,
          :additional_checkbox_text_markdown
        ]
      )
    end

    def admin_params
      params.require(:challenge).permit(
        :submissions_downloadable,
        :dynamic_content_flag,
        :dynamic_content_tab,
        :dynamic_content,
        :dynamic_content_url
      )
    end
  end
end
