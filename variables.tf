variable "gh_pat" {
  type      = string
  sensitive = true
}
variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}
variable "zone_id" {
  type      = string
  sensitive = true
}
variable "oci_api_key" {
  type      = string
  sensitive = true
}
variable "fingerprint" {
  type      = string
  sensitive = true
}
variable "ssh_authorized_key" {
  type      = string
  sensitive = true
}
variable "display_name" {
  type        = string
  default     = "tfx"
  description = "Visible name of vm instance in OCI dashboard"
}

variable "tenancy_ocid" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaazj7ang7mki5ueignzzrm7eutxou3jgfih2uorqufp3kwdcr4puzq"
  description = "Oracle Cloud Infrastructure Tenancy Id"
}
variable "user_ocid" {
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaabrtyu4tlpywthzs57fttnfyvj2mrrmnpbt7s42cb4qo5sbpx52ua"
  description = "Oracle Cloud Infrastructure User Id"
}
variable "region" {
  type        = string
  default     = "eu-amsterdam-1"
  description = "Region where resources will be created"
}


variable "compartment_id" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaazj7ang7mki5ueignzzrm7eutxou3jgfih2uorqufp3kwdcr4puzq"
  description = "Oracle Cloud Infrastructure Compartment Id"
}
variable "instance_name" {
  type        = string
  default     = "tfx"
  description = "Name of the instance."
}
variable "num_instances" {
  type        = number
  default     = 1
  description = "Number of instances"
}
variable "instance_shape_config_memory_in_gbs" {
  type        = number
  default     = 1
  description = "Amount of Memory (GB)"
}
variable "availability_domain" {
  type        = string
  default     = "aLEK:eu-amsterdam-1-AD-1"
  description = "Availability Domain of the instance"
}
variable "instance_source_type" {
  type        = string
  default     = "image"
  description = "The source type for the instance."
}

variable "instance_state" {
  type        = string
  default     = "RUNNING"
  description = "(Updatable) The target state for the instance. Could be set to RUNNING or STOPPED."

  validation {
    condition     = contains(["RUNNING", "STOPPED"], var.instance_state)
    error_message = "Accepted values are RUNNING or STOPPED."
  }
}
variable "assign_public_ip" {
  type        = bool
  default     = true
  description = "Whether the VNIC should be assigned a public IP address."
}
variable "shape" {
  type        = string
  default     = "VM.Standard.E2.1.Micro"
  description = "The shape of an instance."
}
variable "vnic_display_name" {
  type        = string
  default     = "TfxVNIC"
  description = "OCI Virtual Network Interface Card display name"
}
variable "vnic_hostname_label" {
  type        = string
  default     = "tf-cat0"
  description = "OCI hostname label (probably hostname of an instance)"
}
variable "source_id" {
  type        = string
  default     = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaaw5ln7altavlh4ioefojyhbf2fofbpzj4qw77nty23tzjhwz4exba"
  description = "Ubuntu 22.04 image id for eu-amsterdam-1 region see map below"
}
variable "subnet_id" {
  type        = string
  default     = "ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaadlumus4bfnyph5c4i4g2zmtcdx7plc53ph7vrhl7veilf5euw6qq"
  description = "OCI Id of existing subnet connected to specific VNC"
}
variable "create_timeout" {
  type        = string
  default     = "60m"
  description = "Timeout for vm creation"
}

variable "instance_ocpus" {
  default     = 1
  description = "Number of OCPUs"
  type        = number
}
variable "boot_volume_size_in_gbs" {
  default     = 50
  description = "Boot volume size in GBs"
  type        = number
}
variable "instance_image_ocid" {
  type = map(string)

  # See https://docs.us-phoenix-1.oraclecloud.com/images/
  # Canonical-Ubuntu-22.04-Minimal-aarch64-2023.04.18-0
  default = {
    af-johannesburg-1 = "ocid1.image.oc1.af-johannesburg-1.aaaaaaaa46as6w7hwj7tlxphtspc5qumxmhyutdgrjqalxuskm4w5p4qyida"
    ap-chuncheon-1    = "ocid1.image.oc1.ap-chuncheon-1.aaaaaaaah6cio7g5erg3yp4wqyfbu3whtte3hwv4kkdcpnhp4s4xnnjgsuca"
    ap-hyderabad-1    = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaasvngrh46jozz2uzs4wliqhjaf4ztzwljdpx47urdnffdqlodxgaa"
    ap-melbourne-1    = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaadyanfyfn6yenhj6kmoqmvlxlecdfvitsfoqmekmo5wi2tc7oixcq"
    ap-mumbai-1       = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaamhrpfp2nyulgzq3kfqktgq63tvhiqibs4hobsfokek3v4odo5bna"
    ap-osaka-1        = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaliba4aujpehbt3si4o73h66y524lsy2tk5vmbyf65vrc5cw3o55q"
    ap-seoul-1        = "ocid1.image.oc1.ap-seoul-1.aaaaaaaa4o4g4v3u4nv2mtr424z36yaed5hp7jazrxkrjlymkfy77ahmmc5a"
    ap-singapore-1    = "ocid1.image.oc1.ap-singapore-1.aaaaaaaa6ihywkz3f7q6zvux3mfncldtoymvdn2wq3xztjjc3x2n6rgbaoaq"
    ap-sydney-1       = "ocid1.image.oc1.ap-sydney-1.aaaaaaaafyv3xjlybqn77hedfyza4xqj7zomo3sjlqtji5lbozwembozlwba"
    ap-tokyo-1        = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaahsd754q66k7z7unz5d2c27f5mofamlriiy6hs5tl2kecndwc4u5q"
    ca-montreal-1     = "ocid1.image.oc1.ca-montreal-1.aaaaaaaalvgfn6kf2zyv3drlek345dkcsf7zmzycd4jcpbfdxtniyax25vpa"
    ca-toronto-1      = "ocid1.image.oc1.ca-toronto-1.aaaaaaaa5zpkh5zev23zq5veisztq7slcu7gfts4otmgtanry5iqfe777kvq"
    eu-amsterdam-1    = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaaw5ln7altavlh4ioefojyhbf2fofbpzj4qw77nty23tzjhwz4exba"
    eu-frankfurt-1    = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4vff5misacsoq2khjgx5qtqtar6gcga2evkqiioorgllxvgksroq"
    eu-madrid-1       = "ocid1.image.oc1.eu-madrid-1.aaaaaaaally4556huuq5blmvbv2flxqeofmew5qo65wks36ngixpogr76oka"
    eu-marseille-1    = "ocid1.image.oc1.eu-marseille-1.aaaaaaaafykzrva3nqeps3utsjynkmcxdzxpju5vxxop2x63jvlwzdbokdma"
    eu-milan-1        = "ocid1.image.oc1.eu-milan-1.aaaaaaaasjia5iz7g3vcvwjs4kro3lwfbnvtidnj2adybtbjg5smrvul5ezq"
    eu-paris-1        = "ocid1.image.oc1.eu-paris-1.aaaaaaaaocaih6zrjlln6ce7tb3hznwmhi336cyiipuvwfoipl6famk2lhxq"
    eu-stockholm-1    = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaa4m6bpcywhorllqqvienyumblosprnze47smo2f22mz3hnq5fa5lq"
    eu-zurich-1       = "ocid1.image.oc1.eu-zurich-1.aaaaaaaaf46j2kf64b3l5chzn2s6ki4mzjlp2um3o2kkmakl6kyat7lxf7aq"
    il-jerusalem-1    = "ocid1.image.oc1.il-jerusalem-1.aaaaaaaahr4m666wfdbw5nswdlcgy2xiwtsesprboy376adkbqtterygdtca"
    me-abudhabi-1     = "ocid1.image.oc1.me-abudhabi-1.aaaaaaaaqb54pk63ecsttkeq637o553fhtqm2j5q2kh3laxxydn42epnz4eq"
    me-dubai-1        = "ocid1.image.oc1.me-dubai-1.aaaaaaaaexhd4f3pgyq7qkbsca33t5esu5evfl76ccxl6byikdzmc7pkf7za"
    me-jeddah-1       = "ocid1.image.oc1.me-jeddah-1.aaaaaaaagv577d6r2en3jwij742vvn3vjedwfiw6l6fhbstgomaywfkshrda"
    mx-queretaro-1    = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaansgqc5ubd2uqxrsqghcp35t5yvlnx2u2gmm54ln4of2sokvin7nq"
    sa-santiago-1     = "ocid1.image.oc1.sa-santiago-1.aaaaaaaa7jqingynezf6emgmtkyls2j64kczba6gbodihar6ngx5d27yakoq"
    sa-saopaulo-1     = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaalnfzlq4plimtjcnmejd2p3aoecohlj2uxua5vymsribmpiqtq4la"
    sa-vinhedo-1      = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaatj2ifgx7qo56dahfcxlfqfnogykranvii54ap65ei52gtdb6aiha"
    uk-cardiff-1      = "ocid1.image.oc1.uk-cardiff-1.aaaaaaaa5avfn4gly2p45lnjd6ua62xkk22vrxcqfi56zjospg6aou4774xa"
    uk-london-1       = "ocid1.image.oc1.uk-london-1.aaaaaaaaxjmp3psm5nnrgzvdekifdkzejejzyez67nimpc7itoka3zhb3u2a"
    us-ashburn-1      = "ocid1.image.oc1.iad.aaaaaaaa4kk3vwmrprl7elsawu4yincnkteg5yasljeosdly3x25lljfapka"
    us-chicago-1      = "ocid1.image.oc1.us-chicago-1.aaaaaaaaf2cjsuyrnfwetpeukcyx3yd3pa4eqpx2dqserg55acnjqza24vjq"
    us-phoenix-1      = "ocid1.image.oc1.phx.aaaaaaaalz4kuyiaw2og7u5pg53f2ebbtoh6vp5kldo6gxtl3ztv2auykx2q"
    us-sanjose-1      = "ocid1.image.oc1.us-sanjose-1.aaaaaaaad2hwp2mets2z3yczo5kt4yjn6mphzt6lueh7274o6rns7ob32doq"
  }
}
