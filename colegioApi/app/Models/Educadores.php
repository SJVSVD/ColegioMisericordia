<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Educadores extends Model
{
    use HasFactory, SoftDeletes;

    protected $tables = 'educadores';
    protected $primaryKey = 'rut';
    protected $keyType = 'string';
    public $timestamps = false;


    public function nivel(){
        return $this->belongsTo(Nivel::class);
    }



}
