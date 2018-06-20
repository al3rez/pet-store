# frozen_string_literal: true

Rails.application.routes.draw do
  post :sign_up, to: 'users#sign_up'
end
