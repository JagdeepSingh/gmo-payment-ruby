# coding: utf-8

# A client for the GMO Payment API.
#
# example
# gmo = GMO::Payment::AccountAPI.new({
#   shop_id:     "foo",
#   shop_pass:   "bar",
#   host:  "mul-pay.com"
# })
module GMO
  module Payment

    module AccountAPIMethods

      def initialize(options = {})
        @shop_id   = options[:shop_id]
        @shop_pass = options[:shop_pass]
        @host      = options[:host]
        unless @shop_id && @shop_pass && @host
          raise ArgumentError, "Initialize must receive a hash with :shop_id, :shop_pass and either :host! (received #{options.inspect})"
        end
      end

      #########
      # Method
      # Bank_ID
      # Bank_Code
      # Branch_Code
      # Account_Type
      # Account_Name
      # Account_Number
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      # Free
      ### @return ###
      # Bank_ID
      # Method
      # ErrCode
      # ErrInfo
      ### example ###
      # gmo.register_account({
      #   method:            1,
      #   bank_id:           'bank00000',
      #   bank_code:         '0001',
      #   branch_code:       '813',
      #   account_type:      1,
      #   account_name:      'An Yutzy',
      #   account_number:    '0012345',
      #   branch_code_jp:    '00567',
      #   account_number_jp: '01234567',
      #   free:              'foobar'      # Metadata
      # })
      # {"Bank_ID"=>"bank00000", "Method"=>"1"}
      def register_account(options = {})
        name = "/api/AccountRegistration.idPass"
        required = %i(method bank_id bank_code branch_code account_type account_name account_number)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Bank_ID
      ### @return ###
      # Bank_ID
      # Delete_Flag
      # Bank_Name
      # Bank_Code
      # Branch_Name
      # Branch_Code
      # Account_Type
      # Account_Number
      # Account_Name
      # Free
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      ### example ###
      # gmo.search_account({
      #   bank_id: 'bank12345'
      # })
      # {"Bank_ID"=>"bank12345", "Delete_Flag"=>"0", "Bank_Name"=>"みずほ銀行", "Bank_Code"=>"0001", "Branch_Name"=>"札幌支店", "Branch_Code"=>"813", "Account_Type"=>"1", "Account_Number"=>"0012345", "Account_Name"=>"An Yutzy", "Free"=>"", "Branch_Code_Jpbank"=>"", "Account_Number_Jpbank"=>""}
      def search_account(options = {})
        name = "/api/AccountSearch.idPass"
        required = %i(bank_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Method
      # Deposit_ID
      # Bank_ID
      # Amount
      ### @return ###
      # Deposit_ID
      # Bank_ID
      # Method
      # Amount
      # Bank_Fee
      ### example ###
      # gmo.register_deposit({
      #   method:     1,
      #   deposit_id: 'dep00000',
      #   bank_id:    'bank00000',
      #   amount:     '1000'
      # })
      # {"Deposit_ID"=>"dep00000", "Bank_ID"=>"bank00000", "Method"=>"1", "Amount"=>"1000", "Bank_Fee"=>"27"}
      def register_deposit(options = {})
        name = "/api/DepositRegistration.idPass"
        required = %i(method bank_id deposit_id amount)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      # Bank_ID
      ### @return ###
      # Deposit_ID
      # Bank_ID
      # Bank_Name
      # Bank_Code
      # Branch_Name
      # Branch_Code
      # Account_Type
      # Account_Number
      # Account_Name
      # Free
      # Amount
      # Bank_Fee
      # Result
      # Branch_Code_Jpbank
      # Account_Number_Jpbank
      # Deposit_Date
      # Result_Detail
      ### example ###
      # gmo.search_deposit({
      #   deposit_id: 'dep00000'
      # })
      # {"Deposit_ID"=>"dep00000", "Bank_ID"=>"bank163144", "Bank_Name"=>"みずほ銀行", "Bank_Code"=>"0001", "Branch_Name"=>"札幌支店", "Branch_Code"=>"813", "Account_Type"=>"1", "Account_Number"=>"0012345", "Account_Name"=>"An Yutzy", "Free"=>"", "Amount"=>"181035", "Bank_Fee"=>"270", "Result"=>"0", "Branch_Code_Jpbank"=>"", "Account_Number_Jpbank"=>"", "Deposit_Date"=>"", "Result_Detail"=>""}
      def search_deposit(options = {})
        name = "/api/DepositSearch.idPass"
        required = %i(deposit_id)
        assert_required_options(required, options)
        post_request name, options
      end

      #########
      ### @return ###
      # Shop_ID
      # Balance
      # Balance_Forecast
      ### example ###
      # gmo.search_balance
      # {"Shop_ID"=>"rshop00000071", "Balance"=>"9818965", "Balance_Forecast"=>"9818965"}
      def search_balance(options = {})
        name = "/api/BalanceSearch.idPass"
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
