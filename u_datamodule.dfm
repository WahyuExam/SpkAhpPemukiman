object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 176
  Top = 125
  Height = 496
  Width = 689
  object XPManifest1: TXPManifest
    Left = 24
    Top = 16
  end
  object con1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=db_ahp.mdb;Persist ' +
      'Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 104
    Top = 16
  end
  object qry_kawasan: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_kawasan')
    Left = 32
    Top = 80
  end
  object ds_kawasan: TDataSource
    DataSet = qry_kawasan
    Left = 104
    Top = 72
  end
  object qry_kriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_kriteria')
    Left = 32
    Top = 144
  end
  object ds_kriteria: TDataSource
    DataSet = qry_kriteria
    Left = 104
    Top = 136
  end
  object qry_sub_kriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_sub_kriteria')
    Left = 32
    Top = 320
  end
  object qry_tampil_sub_kriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_sub_kriteria, b.kd_kriteria, b.nm_kriteria, a.nm_sub' +
        '_kriteria, a.nl_sub from tbl_sub_kriteria a, tbl_kriteria b wher' +
        'e a.kd_kriteria=b.kd_kriteria')
    Left = 48
    Top = 384
  end
  object ds_sub_kriteria: TDataSource
    DataSet = qry_tampil_sub_kriteria
    Left = 104
    Top = 360
  end
  object qry_kriteria2: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_kriteria')
    Left = 168
    Top = 136
  end
  object ds_kriteria2: TDataSource
    DataSet = qry_kriteria2
    Left = 232
    Top = 128
  end
  object qry_tmp_kriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_tmp_kriteria')
    Left = 168
    Top = 216
  end
  object ds_tmp_kriteria: TDataSource
    DataSet = qry_tmp_kriteria
    Left = 232
    Top = 200
  end
  object qry_indek: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_indek')
    Left = 192
    Top = 64
  end
  object qry_kriteria_tampil: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_kriteria')
    Left = 32
    Top = 208
  end
  object ds_kriteria_tampil: TDataSource
    DataSet = qry_kriteria_tampil
    Left = 112
    Top = 200
  end
  object qry_tmp_sub_kriteria: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_tmp_sub_kriteria')
    Left = 192
    Top = 312
  end
  object ds_tmp_sub_kriteria: TDataSource
    DataSet = qry_tmp_sub_kriteria
    Left = 264
    Top = 280
  end
  object qry_penilaian: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_penilaian')
    Left = 400
    Top = 48
  end
  object qry_tampil_penilaian: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, c.kd' +
        '_sub_kriteria, c.nm_sub_kriteria, c.nl_sub, d.kd_kriteria, d.nm_' +
        'kriteria, d.nl_prioritas, e.parameter_nil, e.nil_param, e.kd_par' +
        'ameter, e.ttl from tbl_rangking a, tbl_kawasan b, tbl_sub_kriter' +
        'ia c, tbl_kriteria d, tbl_penilaian e where a.kd_kawasan=b.kd_ka' +
        'wasan and e.kd_sub_kriteria=c.kd_sub_kriteria and c.kd_kriteria=' +
        'd.kd_kriteria and e.kd_penilaian=a.kd_penilaian ')
    Left = 400
    Top = 112
  end
  object ds_tampil_penilaian: TDataSource
    DataSet = qry_tampil_penilaian
    Left = 472
    Top = 40
  end
  object qry_rangking: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_rangking')
    Left = 392
    Top = 192
  end
  object qry_tampil_rangking: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_penilaian, a.tahun, b.kd_kawasan, b.nm_kawasan, b.al' +
        'mt_kawasan, a.ttl_nilai, a.ket from tbl_rangking a, tbl_kawasan ' +
        'b where a.kd_kawasan=b.kd_kawasan')
    Left = 464
    Top = 208
  end
  object ds_tapil_rangking: TDataSource
    DataSet = qry_tampil_rangking
    Left = 536
    Top = 184
  end
  object tbladmin: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'tbl_pengguna'
    Left = 384
    Top = 264
  end
  object ds_sub_kriteria2: TDataSource
    DataSet = qry_sub_kriteria
    Left = 88
    Top = 288
  end
  object qry_nil_paramaeter: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select a.kd_sub_kriteria, a.nm_sub_kriteria, b.parameter_nil, b.' +
        'nil_param from tbl_sub_kriteria a, tbl_nil_sub_kriteria b where ' +
        'b.kd_sub_kriteria=a.kd_sub_kriteria')
    Left = 384
    Top = 328
  end
  object ds_nil_parameter: TDataSource
    DataSet = qry_nil_paramaeter
    Left = 448
    Top = 312
  end
  object qry_parameter_nil: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_nil_sub_kriteria')
    Left = 384
    Top = 392
  end
  object ds_parameter_nil: TDataSource
    DataSet = qry_parameter_nil
    Left = 464
    Top = 376
  end
  object qry_jawab: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from tbl_jawab')
    Left = 608
    Top = 56
  end
  object dsjawab: TDataSource
    DataSet = qry_jawab
    Left = 624
    Top = 112
  end
end
