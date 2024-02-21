module HuggingFace
  class EndpointsApi < BaseApi

    RETRY_WAIT = 5
    MAX_RETRY = 60
    

    def request(endpoint_url:, input:, params: nil)
      retries = 0

      endpoint_connection = build_connection endpoint_url

      begin
        return super(connection: endpoint_connection, input: { inputs: input }, params: params )
      rescue ServiceUnavailable => exception

        if retries < MAX_RETRY
          logger.debug('Service unavailable, retrying...')
          retries += 1
          sleep RETRY_WAIT
          retry
        else
          raise exception
        end
      end
    end  
        

    private


  end
end
