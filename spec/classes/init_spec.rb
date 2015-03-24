require 'spec_helper'
describe 'umount_nfs' do
  let :facts do
    {
      :osfamily          => 'RedHat',
      :lsbmajdistrelease => '6',
    }
  end

  context 'where parameters are not set' do
    it { should compile.with_all_deps }
    it { should contain_class('umount_nfs') }
    it { should have_resource_count(0) }
  end

  context 'where mount_points are set to an valid array and hiera_merge is set to <false>' do
    it { should contain_class('umount_nfs') }

    [false,true,'false','true'].each do |value|

      if !!value == value
        valuetype = 'boolean'
      else
        valuetype = 'string'
      end

      context "where kill_procs is set to valid <#{value}> (as #{valuetype})" do
        let :params do
          {
            :kill_procs   => value,
            :hiera_merge  => false,
            :mount_points => [
              '/mnt/test',
              '/proj/some_area/',
            ]
          }
        end

        it {
          should contain_umount_nfs__umount('/mnt/test').only_with({
            'name'       => '/mnt/test',
            'with_fuser' => value,
          })
        }
        it {
          should contain_umount_nfs__umount('/proj/some_area/').only_with({
            'name'       => '/proj/some_area/',
            'with_fuser' => value,
          })
        }

      end
    end

    ['invalid',-1,'off','on'].each do |value|
      context "where kill_procs is set to invalid <#{value}>" do
        let :params do
          {
            :kill_procs   => value,
            :hiera_merge  => false,
            :mount_points => [
              '/mnt/test',
              '/proj/some_area/',
            ]
          }
        end
        it 'should fail' do
          expect {
            should contain_class('umount_nfs')
          }.to raise_error(Puppet::Error)
        end

      end
    end

    ['invalid',-1,'off','on'].each do |value|
      context "where hiera_merge is set to invalid <#{value}>" do
        let :params do
          {
            :hiera_merge  => value,
            :mount_points => [
              '/mnt/test',
              '/proj/some_area/',
            ]
          }
        end
        it 'should fail' do
          expect {
            should contain_class('umount_nfs')
          }.to raise_error(Puppet::Error)
        end

      end
    end

  end

  context 'where mount_points are set to an valid array containing doublettes and hiera_merge is set to <false>' do
    let :params do
      {
        :hiera_merge  => false,
        :mount_points => [
          '/mnt/test',
          '/mnt/test',
          '/proj/some_area/',
        ]
      }
    end

    it { should contain_class('umount_nfs') }
    # resource_count is mount_points x 2
    it { should have_resource_count(4) }

  end

end
