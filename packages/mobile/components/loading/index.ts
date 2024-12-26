/**
 * Copyright (c) 2022 - present TinyVue Authors.
 * Copyright (c) 2022 - present Huawei Cloud Computing Technologies Co., Ltd.
 *
 * Use of this source code is governed by an MIT-style license.
 *
 * THE OPEN SOURCE SOFTWARE IN THIS PRODUCT IS DISTRIBUTED IN THE HOPE THAT IT WILL BE USEFUL,
 * BUT WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF MERCHANTABILITY OR FITNESS FOR
 * A PARTICULAR PURPOSE. SEE THE APPLICABLE LICENSES FOR MORE DETAILS.
 *
 */
import service from './src/service'
import directive from './src/directive'
import { setupComponent } from '../../vue-common'

const Loadings: any = {
  install(app) {
    app.directive('loading', directive)
  },
  service,
  directive
}

setupComponent.TINYLoading = {
  init(root) {
    let prefix = root.$apiPrefix || '$'
    root[`${prefix}loading`] = service
  }
}

export default Loadings
