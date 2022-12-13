<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Historial extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'historial';
    protected $primaryKey = 'cod_historial';
    public $incrementing = true;
    protected $keyType = 'int';
    public $timestamps = false;

    public function alumnos(){
        return $this->belongsTo(Alumnos::class);
    }
}

