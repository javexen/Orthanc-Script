#!/bin/bash

# Sample backup script for Orthanc - A Lightweight, RESTful DICOM Store
# Copyright (C) 2014 Karsten Hilbert <Karsten.Hilbert@gmx.net>
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# In addition, as a special exception, the copyright holders of this
# program give permission to link the code of its release with the
# OpenSSL project's "OpenSSL" library (or with modified versions of it
# that use the same license as the "OpenSSL" library), and distribute
# the linked executables. You must obey the GNU General Public License
# in all respects for all of the code used other than "OpenSSL". If you
# modify file(s) with this exception, you may extend this exception to
# your version of the file(s), but you are not obligated to do so. If
# you do not wish to do so, delete this exception statement from your
# version. If you delete this exception statement from all source files
# in the program, then also delete it here.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


BACKUP_DIR="/home/orthanc"


mkdir /tmp/orthanc-backup
rm -f /tmp/orthanc-backup/*


invoke-rc.d orthanc stop
sleep 1
sqlite3 ./index '.databases'
sleep 1
cp -v /var/lib/orthanc/db-v6* /tmp/orthanc-backup/
invoke-rc.d orthanc start


TS=`date +%Y-%m-%d-%H-%M-%S`
cd /tmp
tar --strip-components=1 -cvJf ${BACKUP_DIR}/backup-orthanc-`pacs hospital tawau`-${TS}.tgz orthanc-backup/
cd -


rm -f /tmp/orthanc-backup/*
