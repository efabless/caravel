.. raw:: html

   <!---
   # SPDX-FileCopyrightText: 2020 Efabless Corporation
   #
   # Licensed under the Apache License, Version 2.0 (the "License");
   # you may not use this file except in compliance with the License.
   # You may obtain a copy of the License at
   #
   #      http://www.apache.org/licenses/LICENSE-2.0
   #
   # Unless required by applicable law or agreed to in writing, software
   # distributed under the License is distributed on an "AS IS" BASIS,
   # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   # See the License for the specific language governing permissions and
   # limitations under the License.
   #
   # SPDX-License-Identifier: Apache-2.0
   -->

Repositories and versions to use
================================


===================================================================== ================================================ ===========================
  Repo                                                                         commit                                            version
===================================================================== ================================================ ===========================
`skywater-pdk <https://github.com/google/skywater-pdk.git>`__           ``c094b6e83a4f9298e47f696ec5a7fd53535ec5eb``        \-
`open_pdks <https://github.com/RTimothyEdwards/open_pdks.git>`__        ``6c05bc48dc88784f9d98b89d6791cdfd91526676``    ``1.0.225``
`OpenLane <https://github.com/The-OpenROAD-Project/OpenLane>`__         ``6905a12d2efe18502c37c3207b5ee84cdf720d9c``    ``2021.09.19_20.25.16``
`caravel/caravel-lite <https://github.com/efabless/caravel-lite>`__                 \-                                     ``mpw-three``
`MPW-Precheck <https://github.com/efabless/mpw_precheck>`__                          Latest                                   Latest
===================================================================== ================================================ ===========================


Notes
-----

-  | If you have already successfully hardened your blocks and have a clean
   |  ``user_project_wrapper``, you don't have to recreate it and can just reuse it.
   | This is only if no changes have been made to the user project area or to the tools that
   |  require you to reharden your design(s).

-  | If you will use openlane to harden your blocks, you can refer to
   |  this `README <https://github.com/efabless/caravel/blob/master/openlane/README.rst>`__.

-  | **IMPORTANT**. Do not forget to run ``make uncompress -j4`` in your user project root
   |  directory before you start working. Likewise, before you commit and push your
   |  changes back, run ``make compress -j4``.

-  | If you already have a clean working tree in a previously cloned repository from
   |  those listed above, what you need to do is:
   |  ``git pull   git checkout tag``

