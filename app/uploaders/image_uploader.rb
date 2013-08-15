# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  after :store, :delete_original_file

  def delete_original_file(new_file)
    File.delete path if version_name.blank?
  end


  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :mini do
     process thumbing: 50
  end

  version :small do
    process thumbing: 100
  end

  version :thumb do
    process thumbing: [300, 200]
  end

  version :big do
    process :watermarking
  end

  def thumbing val1, val2=nil
    val2 ||= val1
    manipulate! format: "jpg" do |source|
      source = source.resize_to_fill val1, val2
    end
  end

  def watermarking
    manipulate! format: "png" do |source|
      mark_path = Rails.root.join("app/assets/images/watermark.png")
      mark = Magick::Image.read(mark_path).first
      #source = source.watermark mark
      source = source.composite!(mark, Magick::SouthEastGravity, Magick::OverCompositeOp)
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
