Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "551387658284374", "782a550643d709d9d6a34a06481a18d2"
  provider :twitter, "9fZcXkAZBgrijuuObY5Vg", "AJEfQaFaSPdr7EUFbBlhgl4VU9LM2135gXBrG4Mg"
end