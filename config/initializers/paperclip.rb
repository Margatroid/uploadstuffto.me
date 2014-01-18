# We don't need cache busting on the images throughout the site by default.
# Image URLs will never point to a different image.
Paperclip::Attachment.default_options[:use_timestamp] = false