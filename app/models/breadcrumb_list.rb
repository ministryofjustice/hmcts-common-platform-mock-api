class BreadcrumbList
  Breadcrumb = Data.define(:path, :text)
  delegate :each, to: :breadcrumbs

  def initialize
    @breadcrumbs = []
  end

  attr_reader :breadcrumbs

  def add(text, path = nil)
    @breadcrumbs << Breadcrumb.new(text:, path:)
  end
end
