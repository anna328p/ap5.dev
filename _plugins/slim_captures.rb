# frozen_string_literal: true

module DataProviderExt
  def captures
    @captures ||= {}
  end

  def record(name)
    captures[name.to_sym] = yield
    nil
  end

  def replay(name)
    captures[name.to_sym]
  end
end

module Jekyll
  module Slim
    class DataProvider
      include ::DataProviderExt
    end
  end
end
