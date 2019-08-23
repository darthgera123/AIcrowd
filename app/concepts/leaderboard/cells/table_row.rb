class Leaderboard::Cell::TableRow < Leaderboard::Cell

  def show
    if entry.baseline
      render :baseline_row
    else
      render :table_row
    end
  end

  def entry
    model
  end

  def formatted_score
    return "0.0" if entry.score.nil?
    sprintf("%.#{challenge_round.score_precision}f", entry.score)
  end


  def formatted_score_secondary
    return "0.0" if entry.score_secondary.nil?
    sprintf("%.#{challenge_round.score_precision}f", entry.score_secondary)
  end

  def challenge
    @challenge ||= model.challenge
  end

  def other_scores_array
      other_scores = []
      other_scores_fieldnames_array.each do |fname|
        if entry.meta && (entry.meta.key? fname)
           other_scores << (entry.meta[fname].nil? ? "-": entry.meta[fname])
        else
           other_scores << '-'
        end
      end
      return other_scores
  end

  def participant
    @participant ||= entry.participant
  end

  def team
    @participant ||= entry.team
  end

  def participants
    @participants ||= begin
      case entry.submitter_type
      when 'Participant'
        [entry.participant]
      when 'Team'
        entry.team.participants.to_a
      else
        []
      end
    end
  end

  def top_rows
    @top_rows ||= challenge_round.ranking_highlight
  end

  def leader_class
    if model.row_num <= top_rows
      return 'leader'
    end
  end

end
