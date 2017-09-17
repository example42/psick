#
class psick::aws::ami (
  String $region                    = $::psick::aws::region,
) {

  # Amazon AMI used by default

  # Source: https://aws.amazon.com/marketplace/ordering?productId=b7ee8a69-ee97-4a49-9e68-afaee216db2e&ref_=dtl_psb_continue&region=
  $calculated_image_id_centos7 = $region ? {
    'us-east-1'      => 'ami-6d1c2007',
    'us-west-1'      => 'ami-af4333cf',
    'us-west-2'      => 'ami-d2c924b2',
    'eu-west-1'      => 'ami-7abd0209',
    'eu-central-1'   => 'ami-9bf712f4',
    'ap-northeast-1' => 'ami-eec1c380',
    'ap-northeast-2' => 'ami-c74789a9',
    'ap-southeast-1' => 'ami-f068a193',
    'ap-southeast-2' => 'ami-fedafc9d',
    'ap-south-1'     => 'ami-95cda6fa',
    'sa-east-1'      => 'ami-26b93b4a',
    default          => 'ami-6d1c2007',
  }
  $calculated_image_id_amazon4 = $region ? {
    'us-east-1'      => 'ami-6869aa05',
    'us-west-1'      => 'ami-7172b611',
    'us-west-2'      => 'ami-31490d51',
    'eu-west-1'      => 'ami-f9dd458a',
    'eu-central-1'   => 'ami-ea26ce85',
    'ap-northeast-1' => 'ami-374db956',
    'ap-northeast-2' => 'ami-2b408b45',
    'ap-southeast-1' => 'ami-a59b49c6',
    'ap-southeast-2' => 'ami-dc361ebf',
    'ap-south-1'     => 'ami-ffbdd790',
    'sa-east-1'      => 'ami-6dd04501',
    default          => 'ami-6869aa05',
  }
  $calculated_autoscaling_image_id_amazon4 = $region ? {
    'us-east-1'      => 'ami-a88a46c5',
    'us-west-1'      => 'ami-34a7e354',
    'us-west-2'      => 'ami-ae0acdce',
    'eu-west-1'      => 'ami-ccd942bf',
    'eu-central-1'   => 'ami-4a5eb625',
    'ap-northeast-1' => 'ami-4aab5d2b',
    'ap-southeast-1' => 'ami-24c71547',
    'ap-southeast-2' => 'ami-0bf2da68',
    default          => 'ami-ccd942bf',
  }

}
