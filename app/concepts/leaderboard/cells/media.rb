class Leaderboard::Cell::Media < Leaderboard::Cell

  def show
    render :media
  end

  def leaderboard_row
    model
  end

  def size
    options[:size]
  end

  def submission_id
    options[:submission_id]
  end

  def dimensions
    if size == :thumb
      return "100x75"
    end
    if size == :large
      return "800x600"
    end
  end

  def content_type
    return nil if leaderboard_row.media_content_type.nil?

    media = leaderboard_row.media_content_type.split('/')
    content_type = media[0]
    file_type = media[1]
    return file_type if file_type == 'youtube'

    content_type = nil if ['video','image'].exclude?(content_type)
    return content_type
  end

  def media_asset
    case content_type
    when nil
      return '-'
    when 'image'
      return image
    when 'video'
      return video
    when 'youtube'
      return youtube
    end
  end

  def image
    if public_url.present?
      return image_tag(public_url, size: dimensions, class: "media")
    else
      "-"
    end
  end

  def video
    if public_url.present?
      if size == :large
        return video_tag(public_url, size: dimensions, controls: true, autoplay: true, loop: true, class: "media")
      else
        return video_tag(public_url, size: dimensions, autoplay: true, loop: true, class: "media")
      end
    else
      return "-"
    end
  end

  def youtube
    if size == :thumb && leaderboard_row.media_thumbnail.present?
      url = "https://img.youtube.com/vi/#{leaderboard_row.media_thumbnail}/0.jpg"
      return image_tag(url, size: "100x75", class: "media")
    end
    if size == :large && leaderboard_row.media_large.present?
      result = %Q[
        <iframe title="AIcrowd Video"
          allowfullscreen="allowfullscreen"
          mozallowfullscreen="mozallowfullscreen"
          msallowfullscreen="msallowfullscreen"
          oallowfullscreen="oallowfullscreen"
          webkitallowfullscreen="webkitallowfullscreen"
          width="800"
          height="600"
          src="//www.youtube.com/embed/#{leaderboard_row.media_large }"
          frameborder="0"
          allowfullscreen>
        </iframe>
      ]
      return result.html_safe
    end
  end

  def public_url
    if size == :large
      url = S3Service.new(leaderboard_row.media_large).public_url
    else
      url = S3Service.new(leaderboard_row.media_thumbnail).public_url
    end
  end

end
