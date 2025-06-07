terraform {
  cloud {
    organization = "banana-aviation"
    workspaces {
      name = "lava-funk"
    }
  }
}
