class AudioUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
end
