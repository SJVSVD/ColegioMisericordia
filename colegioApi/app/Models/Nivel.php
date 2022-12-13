<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Nivel extends Model
{
    use HasFactory, SoftDeletes;
    
    protected $table = 'nivel';
    protected $primaryKey = 'cod_nivel';
    public $incrementing = false;
    protected $keyType = 'int';
    public $timestamps = false;


    public function educadores(){
        return $this->hasMany(Educadores::class);
    }
    
    public function alumnos(){
        return $this->hasMany(Alumnos::class);
    }

}
