ExUnit.start()

defmodule TestHelper do
  use ExUnit.Case, async: false
  alias ExTwilio.Api
  import Mock

  def with_fixture(:get!, response, fun),
    do: with_fixture({:get!, fn _url, _headers, _request_opts -> response end}, fun)

  def with_fixture(:post!, response, fun),
    do: with_fixture({:post!, fn _url, _options, _headers, _request_opts -> response end}, fun)

  def with_fixture(:delete!, response, fun),
    do: with_fixture({:delete!, fn _url, _headers, _request_opts -> response end}, fun)

  def with_fixture(stub, fun) do
    with_mock Api, [:passthrough], [stub] do
      fun.()
    end
  end

  def json_response(map, status) do
    %{body: Jason.encode!(map), status_code: status}
  end
end
