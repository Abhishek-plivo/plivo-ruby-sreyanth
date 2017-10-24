require 'rspec'
require 'spec_helper'
require 'plivo'

describe "#validate_signature" do
  it "returns true if signature matches" do
    utils = Plivo::Utils
    expect(utils.validate_signature?('https://answer.url','12345','ehV3IKhLysWBxC1sy8INm0qGoQYdYsHwuoKjsX7FsXc=','my_auth_token')).to eql(true)
  end
  it "returns false if signature does not matches" do
    utils = Plivo::Utils
    expect(utils.validate_signature?('https://answer.url','12345','ehV3IKhLysWBxC1sy8INm0qGoQYdYsHwuoKjsX7FsXc=','my_auth_tokens')).to eql(false)
  end
end
