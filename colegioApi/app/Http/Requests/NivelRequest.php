<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class NivelRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'nombre_nivel' => 'required|unique:nivel,nombre_nivel'
        ];
    }

    public function messages()
    {
        return [
            'nombre_nivel.required' => 'Debe ingresar el nombre del nivel',
            'nombre_nivel.unique' => 'El nombre del nivel ya existe'
        ];
    }

}
