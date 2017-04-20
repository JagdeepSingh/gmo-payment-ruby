# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = GMO::Payment::MailAPI.new({
#   shop_id:     "foo",
#   shop_pass:   "bar",
#   host:  "mul-pay.com"
# })
module GMO
  module Payment
    module MailAPIMethods

      def initialize(options = {})
        @shop_id   = options[:shop_id]
        @shop_pass = options[:shop_pass]
        @host      = options[:host]
        unless @shop_id && @shop_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :shop_id, :shop_pass and either :host! (received #{options.inspect})"
        end
      end

      #########
      # Add params here
      ### @return ###
      # Add response keys here
      ### example ###
      # gmo.deposit_registration({
      # })
      # Add repsonse here
      def deposit_registration(options = {})
        name = "api/MailDepositRegistration.idPass"
        required = []
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Add params here
      ### @return ###
      # Add response keys here
      ### example ###
      # gmo.deposit_search({
      # })
      # Add repsonse here
      def deposit_search(options = {})
        name = "api/MailDepositSearch.idPass"
        required = []
        assert_required_options(required, options)
        post_request name, options
      end

      private

        def api_call(name, args = {}, verb = "post", options = {})
          args.merge!({ "Shop_ID" => @shop_id, "Shop_Pass" => @shop_pass })
          api(name, args, verb, options) do |response|
            if response.is_a?(Hash) && !response["ErrInfo"].nil?
              raise APIError.new(response)
            end
          end
        end

    end
  end
end
