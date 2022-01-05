module Api
  module V1
    class BaseController < ApplicationController
      include Api::ExceptionHandler

      private

      # https://github.com/NoamB/sorcery/issues/724
      # https://qiita.com/okaeri_ryoma/items/0d01469f2265e5d51af1
      def form_authenticity_token; end
    end
  end
end
