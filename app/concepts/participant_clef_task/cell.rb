class ParticipantClefTask::Cell < Template::Cell

  def show
    case participant_status
    when 'profile_incomplete'
      render :profile_incomplete
    when 'unregistered'
      render :participant_unregistered
    when 'requested'
      render :participant_unregistered
    when 'submitted'
      render :participant_submitted
    when 'registered'
      render :task_dataset_files
    end
  end

  def organizer
    @organizer ||= clef_task.organizer
  end

  def clef_task
    model
  end

  def task_dataset_files
    clef_task.task_dataset_files
  end

  def participant_status
    return 'profile_incomplete' if profile_incomplete?
    if participant_clef_task.present?
      return participant_clef_task.status_cd
    else
      return 'unregistered'
    end
  end


  def eua_required?
    true
    #@eua_required ||= clef_task.eua_file.present?
  end

  def participant_clef_task
    @participant_clef_task ||= participant_clef_task = clef_task.participant_clef_tasks.where(participant_id: current_participant.id).first
    #if participant_clef_task.blank? && ['unregistered','requested'].include?(participant_status)
    #  participant_clef_task = ParticipantClefTask.new
    #end
  end

  def profile_incomplete?
    @profile_incomplete ||= begin
      if current_participant.address.blank?
        profile_incomplete = true
      else
        profile_incomplete = false
      end
    end
  end

end
