# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  storage :roz
  require 'carrierwave/storage/roz'

  api_base_url    Settings.roz.api_base_url
  files_base_url  Settings.roz.files_base_url
  access_id       Settings.roz.access_id
  secret_key      Settings.roz.secret_key

  def store_dir
    # Example: "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "#{model.class.to_s.underscore}/#{model.id}"
  end
end
