module TeamsHelper
  def flag_url(team_name)
    country_codes = {
      'Mexico' => 'mx', 'United States' => 'us', 'USA' => 'us', 'Canada' => 'ca',
      'Brazil' => 'br', 'Argentina' => 'ar', 'France' => 'fr', 'Germany' => 'de',
      'Spain' => 'es', 'England' => 'gb-eng', 'Netherlands' => 'nl', 'Portugal' => 'pt',
      'Belgium' => 'be', 'Croatia' => 'hr', 'Japan' => 'jp', 'South Korea' => 'kr',
      'Australia' => 'au', 'South Africa' => 'za', 'Czech Republic' => 'cz',
      'Bosnia and Herzegovina' => 'ba', 'Qatar' => 'qa', 'Switzerland' => 'ch',
      'Morocco' => 'ma', 'Haiti' => 'ht', 'Scotland' => 'gb-sct', 'Paraguay' => 'py',
      'Turkey' => 'tr', 'Curacao' => 'cw', 'Ivory Coast' => 'ci', 'Ecuador' => 'ec',
      'Sweden' => 'se', 'Tunisia' => 'tn', 'Egypt' => 'eg', 'Iran' => 'ir',
      'New Zealand' => 'nz', 'Cape Verde' => 'cv', 'Saudi Arabia' => 'sa', 'Uruguay' => 'uy',
      'Senegal' => 'sn', 'Iraq' => 'iq', 'Norway' => 'no', 'Algeria' => 'dz',
      'Austria' => 'at', 'Jordan' => 'jo', 'DR Congo' => 'cd', 'Uzbekistan' => 'uz',
      'Colombia' => 'co', 'Ghana' => 'gh', 'Panama' => 'pa'
    }
    
    code = country_codes[team_name]
    if code
      "https://flagcdn.com/w80/#{code}.png"
    else
      "https://via.placeholder.com/70x35?text=#{CGI.escape(team_name[0..2])}"
    end
  end
end
