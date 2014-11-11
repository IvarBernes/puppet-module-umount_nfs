require 'spec_helper'

describe 'umount_nfs::umount' do
  context 'where title is set to /mnt/test' do
    let(:title) { '/mnt/test' }
    let :facts do
      {
        :osfamily          => 'RedHat',
        :lsbmajdistrelease => '6',
      }
    end

    context 'where parameters are not set' do

      it { should compile.with_all_deps }

      it {
        should contain_mount('umount-/mnt/test').only_with({
          'ensure' => 'absent',
          'name'   => '/mnt/test',
        })
      }

    end

    context 'where with_fuser is set to' do
      [false,true,'false','true'].each do |value|

        if !!value == value
          valuetype = 'boolean'
        else
          valuetype = 'string'
        end

        context "#{value} (as #{valuetype})" do
          let :params do
            {
              :with_fuser => value,
            }
          end

          it {
            should contain_mount('umount-/mnt/test').only_with({
              'ensure' => 'absent',
              'name'   => '/mnt/test',
            })
          }

          if value == true or value == 'true'
            it {
              should contain_exec('umount_with_fuser-/mnt/test').only_with({
                'command' => 'fuser -k /mnt/test',
                'path'    => [ '/bin', '/sbin', '/usr/sbin' ],
                'returns' => [ '0', '1' ],
                'before'  => 'Mount[umount-/mnt/test]',
              })
            }
          else
            it {
              should_not contain_exec('umount_with_fuser-/mnt/test')
            }
          end

        end
      end
    end

  end
end
