require  "#{File.dirname(__FILE__)}/../lib/rscaffold"

describe RScaffold do

  it 'camelcases a snake_case string' do
    RScaffold.camel_case('foo_bar_baz').should eq 'FooBarBaz'
  end

  describe RScaffold::Project do

    before do
      @p = RScaffold::Project.new 'cool_project'
    end
    
    it 'has a name' do
      @p.name.should eq 'cool_project'
    end

    it 'has a CamelName' do
      @p.camel.should eq 'CoolProject'
    end

    it 'can have the remote reset' do
      new_remote = 'https://some/secure/server/cool_project'
      @p.remote = new_remote
      @p.remote.should eq new_remote 
    end

    it 'generates files' do
      @p.generate('bin').should eq "#/usr/bin/env ruby\n\nrequire 'cool_project'"
    end

  end

end

