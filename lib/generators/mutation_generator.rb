class MutationGenerator < Rails::Generators::NamedBase
  desc 'This generator creates an mutation file inside app/mutations'

  def create_mutation_file
    create_file "app/mutations/#{file_path}.rb", <<~RUBY
      class #{class_name}
        required do
        end

        optional do
        end

        protected

        def execute; end

        def validate; end
      end
    RUBY
  end
end
