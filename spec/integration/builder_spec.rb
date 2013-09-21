require 'spec_helper'
require 'tempfile'

describe 'AudioGlue::Builder integration' do

  let(:output_file) { gen_tmp_filename('wav') }
  let(:builder) { AudioGlue::Builder.new }


  context 'Template with local files' do
    let(:template_class) do
      Class.new(AudioGlue::Template) do
        self.rate     = 96000
        self.channels = 1

        def build(packet)
          packet << file(input_fixture('hi.wav'))
          packet << file(input_fixture('hi.wav'))

          if @smalltalk
            packet << file(input_fixture('how_are_you_doing.wav'))
            packet << file(input_fixture('fine_thanks.wav'))
          end

          packet << file(input_fixture('bye_bye.wav'))
        end
      end
    end


    it 'should build audio without smalltalk' do
      template = template_class.new
      builder.write(template, output_file)

      output_file.should sound_like output_fixture('hi_hi_bye_bye.wav')
    end

    it 'should build audio with smalltalk' do
      template = template_class.new(:smalltalk => true)
      builder.write(template, output_file)

      output_file.should sound_like output_fixture('hi_hi_how_are_you_fine_bye.wav')
    end
  end

end
