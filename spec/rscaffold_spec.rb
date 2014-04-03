require  "#{File.dirname(__FILE__)}/../lib/rscaffold"
include FileUtils


describe RScaffold do

  before(:all) do
    FileUtils.mkdir_p 'test_output'
    Dir.chdir 'test_output'
  end

  it 'camelcases a snake_case string' do
    RScaffold.camel_case('foo_bar_baz').should eq 'FooBarBaz'
  end

  describe RScaffold::Project do

    before do
      @output_bin = "#!/usr/bin/env ruby\n\nrequire 'my_project'\n"
      @p = RScaffold::Project.new 'my_project'
    end
    
    it 'has a name' do
      @p.name.should eq 'my_project'
    end

    it 'has a CamelName' do
      @p.camel.should eq 'MyProject'
    end

    it 'can have the remote reset' do
      new_remote = 'https://some/secure/server/my_project'
      @p.remote = new_remote
      @p.remote.should eq new_remote 
    end

    it 'renders templates' do
      @p.rendered('bin').should eq @output_bin
    end

    it 'makes destination files' do
      @p.write('bin')
      File.read('bin/my_project').should eq @output_bin
    end

  end

  after(:all) do
    Dir.chdir '..'
    FileUtils.rm_r 'test_output'
  end

end

