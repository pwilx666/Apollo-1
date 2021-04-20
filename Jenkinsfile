#!groovy

@Library('pipelib')
import org.veupathdb.lib.Builder

node('centos8') {
  sh "env"

  def builder = new Builder(this)

  // because of the JBrowse submodule, Apollo requires a custom checkout
  checkout([$class: 'GitSCM',
      branches: [[name: env.BRANCH_NAME ]],
      doGenerateSubmoduleConfigurations: false,
      extensions: [
        [$class: 'SubmoduleOption',
          disableSubmodules: false,
          parentCredentials: false,
          recursiveSubmodules: true,
          reference: '',
          trackingSubmodules: false]
        ],
      submoduleCfg: [],
      userRemoteConfigs: [[url: 'https://github.com/VEuPathDB/Apollo.git']]
    ]
  )

  builder.buildContainers([
    [ name: 'apollo',           dockerfile: "Dockerfile-apollo"   ],
    [ name: 'oauthproxy',       dockerfile: "Dockerfile-httpd"    ],
    [ name: 'postgres-apollo',  dockerfile: "Dockerfile-postgres" ],
  ])
}

