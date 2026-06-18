module ChannelsHelper
  def channel_logo_url(channel)
    if channel.logo.present?
      asset_path(channel.logo)
    else
      "https://via.placeholder.com/50x25?text=#{CGI.escape(channel.name[0..3])}"
    end
  end
end