class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  process :save_content_type_and_size_in_model

  def save_content_type_and_size_in_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
  end

end
