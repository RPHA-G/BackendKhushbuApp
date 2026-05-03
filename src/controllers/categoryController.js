const { supabase } = require("../config/supabase");

// Get all categories with subcategories
const getAllCategories = async (req, res, next) => {
  try {
    const { data: categories, error } = await supabase
      .from("categories")
      .select(
        `
        *,
        subcategories (*)
      `
      )
      .eq("is_active", true)
      .order("display_order", { ascending: true });

    if (error) throw error;

    res.json({ categories });
  } catch (error) {
    next(error);
  }
};

// Get single category with subcategories
const getCategoryById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const { data: category, error } = await supabase
      .from("categories")
      .select(
        `
        *,
        subcategories (*)
      `
      )
      .eq("id", id)
      .eq("is_active", true)
      .single();

    if (error) throw error;

    res.json({ category });
  } catch (error) {
    next(error);
  }
};

// Get subcategories by category
const getSubcategories = async (req, res, next) => {
  try {
    const { categoryId } = req.params;

    const { data: subcategories, error } = await supabase
      .from("subcategories")
      .select("*")
      .eq("category_id", categoryId)
      .eq("is_active", true)
      .order("display_order", { ascending: true });

    if (error) throw error;

    res.json({ subcategories });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getAllCategories,
  getCategoryById,
  getSubcategories,
};
