<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Penggunaan extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Mpenggunaan');
        $this->load->model('Mbarang');
        $this->load->model('Muser');
        if (!$this->session->userdata("store")) {
            $this->session->set_flashdata('pesan', 'Anda harus login');
            redirect('', 'refresh');
        }
    }

    public function index()
    {
        $data['title'] = 'Penggunaan Bahan Baku';
        $data['penggunaan'] = $this->Mpenggunaan->tampil_penggunaan();
        $this->load->view('header', $data);
        $this->load->view('store/navbar', $data);
        $this->load->view('store/penggunaan/datapenggunaan', $data);
        $this->load->view('footer');
    }

    public function tambah()
    {

        //gunakan lib form_validation untuk me required
        $this->form_validation->set_rules('id_user', 'Pembuat', 'required');
        $this->form_validation->set_rules('kode_penggunaan', 'Kode Penggunaan', 'required');
        $this->form_validation->set_rules('tgl_penggunaan', 'Tanggal', 'required');
        $this->form_validation->set_rules('shift', 'Shift', 'required');

        $inputan = $this->input->post();
        //jk ada inputan dari formulir

        // jk validation benar 
        if ($this->form_validation->run() == TRUE) {
            //Mpenggunaan jalankan fungsi tambah($inputan)
            $query = $this->Mpenggunaan->tambah($inputan);
            //tampilkan store/tambah/pengurangan
            if ($query == "sukses") {
                $this->session->set_flashdata('pesan', 'Data berhasil dikurangi!');
                redirect('store/penggunaan/', 'refresh');
            } elseif ($query == "gagal") {
                $this->session->set_flashdata('gagal', 'Gagal!');
                redirect('store/penggunaan/', 'refresh');
            }
        } else {
            $data['gagal'] = validation_errors();
        }

        $data['kode_penggunaan'] = $this->Mpenggunaan->kode_penggunaan();
        $data['barang'] = $this->Mbarang->tampil_barang();
        $data['title'] = 'Tambah Penggunaan Bahan Baku';

        $this->load->view('header', $data);
        $this->load->view('store/navbar', $data);
        $this->load->view('store/penggunaan/tambahdata', $data);
        $this->load->view('footer');
    }

    public function hapus()
    {
        $idnya = $this->input->post("id");
        $this->Mpenggunaan->hapus($idnya);
    }

    public function detail($id_penggunaan)
    {
        $data['penggunaan'] = $this->Mpenggunaan->detail_penggunaan($id_penggunaan);
        $data['detailpenggunaan'] = $this->Mpenggunaan->tampil_detailpenggunaan($id_penggunaan);

        $data['title'] = 'Detail Penggunaan Bahan Baku';
        $this->load->view('header', $data);
        $this->load->view('store/navbar', $data);
        $this->load->view('store/penggunaan/detailpenggunaan', $data);
        $this->load->view('footer');
    }

    public function tambahdetail($id_penggunaan)
    {

        // gunakan lib form_validation untuk me required
        $this->form_validation->set_rules('id_penggunaan', 'Penggunaan', 'required');
        $this->form_validation->set_rules('id_barang', 'Barang', 'required'); 
        $this->form_validation->set_rules('jumlah_penggunaan', 'Jumlah Penggunaan', 'required|is_natural_no_zero');
        $this->form_validation->set_rules(
            'hasil',
            'Jumlah Penggunaan',
            'required|greater_than_equal_to[0]',
            array('greater_than_equal_to' => 'Kurangi Jumlah Penggunaan')
        );

        $inputan = $this->input->post();
        //jk ada inputan dari formulir

        // jk validation benar 
        if ($this->form_validation->run() == TRUE) {
            //Mpenggunaan jalankan fungsi simpan_detailpenggunaan($inputan)
            $query = $this->Mpenggunaan->simpan_detailpenggunaan($inputan);
            //tampilkan store/penggunaan/detail
            if ($query == "sukses") {
                $this->session->set_flashdata('pesan', 'Data berhasil ditambah!');
                redirect('store/penggunaan/detail/' . $id_penggunaan, 'refresh');
            } elseif ($query == "gagal") {
                $this->session->set_flashdata('gagal', 'Barang sudah ada!');
                redirect('store/penggunaan/detail/' . $id_penggunaan, 'refresh');
            }
        } else {
            $data['gagal'] = validation_errors();
        }

        $data['title'] = 'Tambah Penggunaan Bahan Baku';
        $data['id_penggunaan'] = $id_penggunaan;
        $data['barang'] = $this->Mbarang->tampil_barang();

        $this->load->view('header', $data);
        $this->load->view('store/navbar', $data);
        $this->load->view('store/penggunaan/tambahdetail', $data);
        $this->load->view('footer');
    }

    public function detailubah($id_penggunaan, $id_detailpenggunaan)
    {
        $inputan = $this->input->post();
        // jk submit maka lakukan

        if ($inputan) {
            //mengambil detail dari Model Mpenggunaan
            $detail = $this->Mpenggunaan->detail_detailpenggunaan($id_detailpenggunaan);

            //jika ada inputan ada maka jalankan validasi   
            $this->form_validation->set_rules('jumlah_penggunaan', 'Jumlah Permintaan Barang', 'required|is_natural_no_zero');
            $this->form_validation->set_rules(
                'hasilstore',
                'Hasil',
                'greater_than_equal_to[0]',
                array('greater_than_equal_to' => 'Stock store tidak tersedia silahkan kurangi jumlah permintaan')
            );

            // jalankan validasi jika benar
            if ($this->form_validation->run() == TRUE) {

                $this->Mpenggunaan->ubah_detailpenggunaan($inputan, $id_detailpenggunaan);
                $this->session->set_flashdata('pesan', 'Data berhasil diubah!');
                redirect('store/penggunaan/detail/' . $id_penggunaan, 'refresh');
            }
            // jika salah maka 
            $data['gagal'] = validation_errors();
        }
        $data["detailpenggunaan"] = $this->Mpenggunaan->detail_detailpenggunaan($id_detailpenggunaan);
        $data['title'] = 'Ubah Detail Permintaan Barang';
        $data['id_penggunaan'] = $id_penggunaan;
        $data['barang'] = $this->Mbarang->tampil_barang();

        $this->load->view('header', $data);
        $this->load->view('store/navbar', $data);
        $this->load->view('store/penggunaan/editdetailpenggunaan', $data);
        $this->load->view('footer');
    }

    public function konfirmasi($id_penggunaan)
    {

        // gunakan lib form_validation untuk me required 
        $this->form_validation->set_rules('status', 'Status', 'required');

        $inputan = $this->input->post();
        //jk ada inputan dari formulir

        // jk validation benar 
        if ($this->form_validation->run() == TRUE) {
            //Mpenggunaan jalankan fungsi konfirmasi($inputan)
            $query = $this->Mpenggunaan->konfirmasi_penggunaan($inputan, $id_penggunaan);
            //tampilkan store/penggunaan/konfirmasi
            if ($query == "sukses") {
                $this->session->set_flashdata('pesan', 'Data berhasil diubah!');
                redirect('store/penggunaan/detail/' . $id_penggunaan, 'refresh');
            } elseif ($query == "gagal") {
                $this->session->set_flashdata('gagal', 'Barang sudah ada!');
                redirect('store/penggunaan/detail/' . $id_penggunaan, 'refresh');
            }
        } else {
            $data['gagal'] = validation_errors();
        }

        $data['title'] = 'Konfirmasi Penggunaan Bahan Baku';
        $data['penggunaan'] = $this->Mpenggunaan->detail_penggunaan($id_penggunaan);
        $data['detailpenggunaan'] = $this->Mpenggunaan->tampil_detailpenggunaan($id_penggunaan);


        $this->load->view('header', $data);
        $this->load->view('store/navbar', $data);
        $this->load->view('store/penggunaan/konfirmasi', $data);
        $this->load->view('footer');
    }
 

    public function hapusdetail()
    {
        $idnya = $this->input->post("id");
        $this->Mpenggunaan->hapus_detailpenggunaan($idnya);
    }

    public function cetak($id_penggunaan)
    {
        $data['penggunaan'] = $this->Mpenggunaan->detail_penggunaan($id_penggunaan);
        $data['detailpenggunaan'] = $this->Mpenggunaan->cetakdetail($id_penggunaan);

        $data['title'] = 'Cetak Penggunaan Bahan Baku';

        $this->load->view('store/penggunaan/cetakpenggunaan', $data);
    }


}
